using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class GameManager : MonoBehaviour
{
    public static GameManager instance;

    [SerializeField] GameObject endGamePopup;
    public GameEvent onEndGame;
    internal NewHolderInvoker newHolderInvoker;
    internal bool undoing;

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
        newHolderInvoker = new NewHolderInvoker();

        var popUp = Instantiate(endGamePopup, Vector3.zero, Quaternion.identity);
        DontDestroyOnLoad(popUp);  
    }
    public void ResetLevel()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
        DataManager.instance.winCountdown = 0;
        undoing = false;
    }
    public void OnEndGame()
    {
        onEndGame.RaiseEvent();
    }
    public void UndoPiece()
    {
        if (!undoing)
        {
            undoing = true;
            newHolderInvoker.UndoCommand();
        }
    }
}
