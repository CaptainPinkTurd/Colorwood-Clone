using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Unity.VisualScripting;
using UnityEngine;

public class QualifiedState : IWoodHolderState
{
    public void EnterState(StateManager stateManager, WoodHolder holder)
    {
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

        yield return new WaitForSeconds(0.3f); //suspend until withdraw

        while (timeElapsed < transitionDuration)
        {
            float t = (timeElapsed / transitionDuration) * 0.45f;

            piece.sprite.color = Color.Lerp(a, b, t);
            timeElapsed += Time.deltaTime;

            yield return null;
        }
    }
}
