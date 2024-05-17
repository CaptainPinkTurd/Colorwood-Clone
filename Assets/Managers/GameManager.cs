using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class GameManager : MonoBehaviour
{
    [SerializeField] GameObject endGamePopup;
    public GameEvent onEndGame;
    public static GameManager instance;

    void Awake()
    {
        if (instance == null)
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
        var popUp = Instantiate(endGamePopup, Vector3.zero, Quaternion.identity);
        DontDestroyOnLoad(popUp);  
    }
    public void ResetLevel()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
        DataManager.instance.winCountdown = 0;
    }
    public void OnEndGame()
    {
        onEndGame.RaiseEvent();
    }
}
