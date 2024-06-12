using Mkey;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.SceneManagement;

public class GameManager : MonoBehaviour
{
    public static GameManager instance;

    [SerializeField] GameObject winPopup;
    [SerializeField] GameObject losePopup;
    [SerializeField] private LayerMask holderMask;
    [SerializeField] GameEvent onNewHolder;

    [Header("Game State")]
    internal NewHolderInvoker newHolderInvoker; //use to invoke command
    internal bool gameOver;
    internal bool canUndo;
    public static event Action onUndo;

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
        onUndo += newHolderInvoker.UndoCommand;
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
    public void OnWin()
    {
        if(MapController.currentLevel > MapController.topPassedLevel)
        {
            //unlock new level after beating the latest one
            MapController.topPassedLevel++;
            //save current data
            DataManager.instance.SaveGameData();
        }

        var endgameUI = Instantiate(winPopup, transform.position, Quaternion.identity);
        SceneManager.MoveGameObjectToScene(endgameUI, SceneManager.GetSceneByBuildIndex((int)EnumData.SceneIndexes.LEVEL));

        gameOver = true;
    }
    public void OnLose()
    {
        var endgameUI = Instantiate(losePopup, transform.position, Quaternion.identity);
        SceneManager.MoveGameObjectToScene(endgameUI, SceneManager.GetSceneByBuildIndex((int)EnumData.SceneIndexes.LEVEL));
    }
    internal IEnumerator LoseConditionCheck(int movesLeft)
    {
        if(movesLeft == 0) gameOver = true;

        yield return new WaitForSeconds(1); //wait in case the player has won

        if (movesLeft == 0 && DataManager.instance.winCountdown > 0) OnLose();
    }
    public void UndoPiece()
    {
        Debug.Log("can undo: " + canUndo);
        if (onUndo == null) onUndo += newHolderInvoker.UndoCommand;

        if (!canUndo) onUndo = null;

        canUndo = false;
        onUndo?.Invoke();
    }
    internal void OnNewHolderEvent()
    {
        onNewHolder.RaiseEvent();
    }
}
