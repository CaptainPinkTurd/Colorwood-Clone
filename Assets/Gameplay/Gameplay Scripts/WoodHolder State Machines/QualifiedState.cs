using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Unity.VisualScripting;
using UnityEngine;

public class QualifiedState : IWoodHolderState
{
    private bool isUndoing;
    public void EnterState(StateManager stateManager, WoodHolder holder)
    {
        GameManager.onUndo += UndoEvent;

        CubeChunk chunk = holder.chunkStack.FirstOrDefault();

        int pieceInChunk = chunk.transform.childCount;

        for (int i = 0; i < pieceInChunk; i++)
        {
            CubePiece piece = chunk.transform.GetChild(i).GetComponent<CubePiece>();
            holder.StartCoroutine(LerpWithdrawPiece(Color.white, Color.black, piece));
        }

        DataManager.instance.winCountdown--;

        if(DataManager.instance.winCountdown == 0)
        {
            GameManager.instance.OnWin();
        }
    }
    public void ExitState()
    {
        DataManager.instance.winCountdown++;
    }
    IEnumerator LerpWithdrawPiece(Color a, Color b, CubePiece piece)
    {
        float timeElapsed = 0;
        float transitionDuration = 0.45f;

        isUndoing = false; //switch back to false everytime this function run so it wouldn't affect the condition

        yield return new WaitForSeconds(0.3f); //suspend until withdraw

        while (timeElapsed < transitionDuration) 
        {
            if (isUndoing)
            {
                //if isUndoing is true, it means that the game is undoing and therefore the piece should change back to white
                a = piece.sprite.color;
                b = Color.white;
            }
            float t = (timeElapsed / transitionDuration) * 0.45f;

            piece.sprite.color = Color.Lerp(a, b, t);
            timeElapsed += Time.deltaTime;

            yield return null;
        }
    }
    private void UndoEvent()
    {
        //this function is usually called after exit state
        isUndoing = true;
        GameManager.onUndo -= UndoEvent; 
    }
}
