using Mkey;
using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public class DataManager : MonoBehaviour
{
    public static DataManager instance;

    [SerializeField] internal CubeChunk selectedChunk = null;
    [SerializeField] internal WoodHolder lastSelectedHolder = null;
    [SerializeField] internal int pieceNeededToRemove = 0;
    [SerializeField] internal int winCountdown = 0;

    internal GameObject lastLobbyCube;
    internal bool chunkIsMoving;

    internal const float heightDifference = 0.6f;
    internal const float maxHeight = 1.8f;

    [Header("Data Persistence")]
    private IDataService DataService = new JsonDataService();
    private bool EncryptionEnabled;
    private long SaveTime;
    private long LoadTime;


    void Awake()
    {
        if(instance == null)
        {
            instance = this;
            DontDestroyOnLoad(gameObject);
        }
        else
        {
            Destroy(gameObject);
        }
    }
    private void Start()
    {
        ToggleEncryption(true);
        LoadGameData();
    }

    public void ResetVariables()
    {
        chunkIsMoving = false;
        selectedChunk = null;
        lastSelectedHolder = null;
        pieceNeededToRemove = 0;
        winCountdown = 0;

        GameManager.instance.canUndo = true;
    }
    public void ToggleEncryption(bool EncryptionEnabled)
    {
        this.EncryptionEnabled = EncryptionEnabled;
    }
    public void SaveGameData()
    {
        long StartTime = DateTime.Now.Ticks;
        if(DataService.SaveData("/top-passed-level.json", MapController.topPassedLevel, EncryptionEnabled))
        {
            SaveTime = DateTime.Now.Ticks - StartTime;
            Debug.Log("Save time: " + SaveTime / 1000f + "ms");
        }
        else
        {
            Debug.LogError("Could not save file!");
        }
    }
    public void LoadGameData()
    {
        long StartTime = DateTime.Now.Ticks;
        try
        {
            MapController.topPassedLevel = DataService.LoadData<int>("/top-passed-level.json", EncryptionEnabled);
            LoadTime = DateTime.Now.Ticks - StartTime;
            Debug.Log("Load time: " + LoadTime / 1000f + "ms");
        }
        catch(Exception e)
        {
            Debug.LogError("Could not read file, could be due to a new file");
        }
    }
}
