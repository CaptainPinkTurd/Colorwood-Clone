using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.SceneManagement;

public class ViewManager : MonoBehaviour
{
    public static ViewManager instance;

    [SerializeField] GameObject loadingScreen;
    [SerializeField] TMP_Text loadingText;
     
    List<AsyncOperation> sceneLoading = new List<AsyncOperation>(); 

    private void Awake()
    {
        if (instance == null)
        {
            instance = this;
            DontDestroyOnLoad(gameObject);
            DontDestroyOnLoad(loadingScreen);

        }
        else
        {
            Destroy(gameObject);
        }
    }

    private void Start()
    {
        //LoadUiScene();
        LoadLobby();
    }
    public void LoadLobby()
    {
        GameManager.instance.gameOver = false;

        loadingScreen.gameObject.SetActive(true);

        if (SceneManager.GetSceneByBuildIndex((int)EnumData.SceneIndexes.LEVEL).isLoaded)
        {
            //unload scene level if it's currently loaded
            sceneLoading.Add(SceneManager.UnloadSceneAsync((int)EnumData.SceneIndexes.LEVEL));
        }

        sceneLoading.Add(SceneManager.LoadSceneAsync((int)EnumData.SceneIndexes.LOBBY, LoadSceneMode.Additive));

        StartCoroutine(GetSceneLoadProgress());
    }
    public void LoadLevel()
    {
        loadingScreen.gameObject.SetActive(true);
        sceneLoading.Add(SceneManager.UnloadSceneAsync((int)EnumData.SceneIndexes.LOBBY));
        sceneLoading.Add(SceneManager.LoadSceneAsync((int)EnumData.SceneIndexes.LEVEL, LoadSceneMode.Additive));

        StartCoroutine(GetSceneLoadProgress());
    }
    public void ResetLevel()
    {
        loadingScreen.gameObject.SetActive(true);
        sceneLoading.Add(SceneManager.UnloadSceneAsync((int)EnumData.SceneIndexes.LEVEL));
        sceneLoading.Add(SceneManager.LoadSceneAsync((int)EnumData.SceneIndexes.LEVEL, LoadSceneMode.Additive));

        StartCoroutine(GetSceneLoadProgress());
    }
    public IEnumerator GetSceneLoadProgress()
    {
        float totalSceneProgress;

        for(int i = 0;  i < sceneLoading.Count; i++)
        {
            while (!sceneLoading[i].isDone)
            {
                totalSceneProgress = 0;

                foreach (AsyncOperation operation in sceneLoading)
                {
                    totalSceneProgress += operation.progress;
                }

                totalSceneProgress = (totalSceneProgress / sceneLoading.Count) * 100f;

                loadingText.text = $"{Mathf.RoundToInt(totalSceneProgress)}%";
                yield return null;
            }
        }
        loadingScreen.gameObject.SetActive(false);

        if (SceneManager.GetSceneByBuildIndex((int)EnumData.SceneIndexes.LEVEL).isLoaded)
        {
            GameManager.instance.gameObject.GetComponent<LevelGenerate>().GenerateLevel();
        }
    }
    public void PlayScene(EnumData.SceneIndexes scene)
    {
        SceneManager.LoadSceneAsync((int)scene, LoadSceneMode.Additive);
    }
    public void UnloadScene(EnumData.SceneIndexes scene)
    {
        SceneManager.UnloadSceneAsync((int)scene);
    }
}
