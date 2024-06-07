using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using UnityEngine;

public class JsonDataService : IDataService
{
    //uncomment the codes below to see a generated value for IV and Key.

    //using Aes aesProvider = Aes.Create();
    //aesProvider.GenerateIV();
    //aesProvider.GenerateKey();
    //Debug.Log($"Generated IV: {Convert.ToBase64String(aesProvider.IV)}");
    //Debug.Log($"Generated Key: {Convert.ToBase64String(aesProvider.Key)}");

    private const string KEY = "NW3QTy/6/H0l+P7244rM/p6pgRHJ4oTP3VNlmUU3fZs=";
    private const string IV = "Rkc2MMUPg4kE4l56X01dew==";
    public bool SaveData<T>(string RelativePath, T Data, bool Encrypted)
    {
        string path = Application.persistentDataPath + RelativePath;
        try
        {
            if (File.Exists(path))
            {
                Debug.Log("Data exists. Deleting old file and writing a new one");
                File.Delete(path);
            }
            else
            {
                Debug.Log("Creating file for the first time");
            }

            using FileStream stream = File.Create(path);
            if (Encrypted)
            {
                WriteEncryptedData(Data, stream);
            }
            else
            {
                //close the stream path to the file immediately so that we can write data into it
                //or else we will get exception saying this file is already in use
                stream.Close();

                //Converting data into json format
                File.WriteAllText(path, JsonConvert.SerializeObject(Data));
            }
            return true;
        }
        catch (Exception e)
        {
            //in case anything bad happen in that whole process
            Debug.LogError($"Unable to save data due to: {e.Message}  {e.StackTrace}");

            return false;
        }
    }
    private void WriteEncryptedData<T>(T data, FileStream stream)
    {
        using Aes aesProvider = Aes.Create();
        aesProvider.Key = Convert.FromBase64String(KEY);
        aesProvider.IV = Convert.FromBase64String(IV);
        using ICryptoTransform cryptoTransform = aesProvider.CreateEncryptor();
        using CryptoStream cryptoStream = new CryptoStream(
            stream,
            cryptoTransform,
            CryptoStreamMode.Write);

        cryptoStream.Write(Encoding.ASCII.GetBytes(JsonConvert.SerializeObject(data)));
    }

    public T LoadData<T>(string RelativePath, bool Encrypted)
    {
        string path = Application.persistentDataPath + RelativePath;
        if (!File.Exists(path))
        {
            Debug.LogError($"Cannot load file at {path}. File does not exist!");
            throw new FileNotFoundException($"{path} does not exist!");
        }
        try
        {
            T data;
            if (Encrypted)
            {
                data = ReadEncryptedData<T>(path);
            }
            else
            {
                data = JsonConvert.DeserializeObject<T>(File.ReadAllText(path));
            }
                
            return data;
        }
        catch(Exception e)
        {
            Debug.LogError($"Failed to load data due to: {e.Message}  {e.StackTrace}");
            throw e;
        }
    }
    private T ReadEncryptedData<T>(string path)
    {
        byte[] fileBytes = File.ReadAllBytes(path);
        using Aes aesProvider = Aes.Create();

        aesProvider.Key = Convert.FromBase64String(KEY);
        aesProvider.IV = Convert.FromBase64String(IV);

        using ICryptoTransform cryptoTransform = aesProvider.CreateDecryptor(
            aesProvider.Key,
            aesProvider.IV
            );
        using MemoryStream decryptionStream = new MemoryStream(fileBytes);
        using CryptoStream cryptoStream = new CryptoStream(
            decryptionStream,
            cryptoTransform,
            CryptoStreamMode.Read);
        using StreamReader reader = new StreamReader(cryptoStream);

        string result = reader.ReadToEnd();

        Debug.Log($"Decrypted result (if the following is not legible, probably wrong key or iv): {result}");
        return JsonConvert.DeserializeObject<T>(result);
    }
}
