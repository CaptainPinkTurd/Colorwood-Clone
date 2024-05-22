using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class GameManager : MonoBehaviour
{
    [SerializeField] GameObject winPopup;
    [SerializeField] GameObject losePopup;

    [SerializeField] GameEvent onNewHolder;

    public static GameManager instance;

    internal NewHolderInvoker newHolderInvoker;
    internal bool undoing;

    Vector3 popUpPos;

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

        ViewManager.instance.LoadUiScene();
    }
    public void ResetLevel()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
        ViewManager.instance.LoadUiScene();

        DataManager.instance.winCountdown = 0;
        undoing = false;
    }
    public void OnWin()
    {
        Instantiate(winPopup, popUpPos, Quaternion.identity);
    }
    public void OnLose()
    {
        Instantiate(losePopup, popUpPos, Quaternion.identity);
    }
    public void UndoPiece()
    {
        if (!undoing)
        {
            undoing = true;
            newHolderInvoker.UndoCommand();
        }
    }
    internal void OnNewHolderEvent()
    {
        onNewHolder.RaiseEvent();
    }
}
