using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.SceneManagement;

public class GameManager : MonoBehaviour
{
    [SerializeField] GameObject winPopup;
    [SerializeField] GameObject losePopup;
    [SerializeField] private LayerMask holderMask;

    internal bool gameOver;

    [SerializeField] GameEvent onNewHolder;

    public static GameManager instance;

    internal NewHolderInvoker newHolderInvoker;
    internal bool canUndo;

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
    void Start()
    {
        newHolderInvoker = new NewHolderInvoker();
    }
    void Update()
    {
        RaycastHit2D ray = Physics2D.Raycast(Camera.main.ScreenToWorldPoint(Input.mousePosition), Vector2.zero,
                Mathf.Infinity, holderMask);
        if (ray.collider)
        {
            if (Input.GetMouseButtonDown(0) && !gameOver)
            {
                StateManager state = ray.collider.GetComponent<WoodHolder>().state;

                state.currentState.OnClick(state);
            }
            return;
        }
        else if (Input.GetMouseButtonDown(0)) //if touch screen instead of holder
        {
            if (DataManager.instance.selectedChunk != null)
            {
                StateManager state = DataManager.instance.selectedChunk.transform.GetComponentInParent<WoodHolder>().state;

                state.currentState.OnClick(state);
            }
        }
    }
    public void ResetLevel()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
        //ViewManager.instance.LoadUiScene();

        DataManager.instance.winCountdown = 0;
        canUndo = true;
    }
    public void OnWin()
    {
        Instantiate(winPopup, transform.position, Quaternion.identity);
        gameOver = true;
    }
    public void OnLose()
    {
        Instantiate(losePopup, transform.position, Quaternion.identity);
        gameOver = true;
    }
    public void UndoPiece()
    {
        if (canUndo)
        {
            canUndo = false;
            newHolderInvoker.UndoCommand();
        }
    }
    internal void OnNewHolderEvent()
    {
        onNewHolder.RaiseEvent();
    }
}
