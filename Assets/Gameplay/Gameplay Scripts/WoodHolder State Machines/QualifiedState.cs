using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.WSA;

public class QualifiedState : IWoodHolderState
{
    public void EnterState(StateManager stateManager, WoodHolder holder)
    {
        CubeChunk chunk = holder.chunkStack.FirstOrDefault();

        chunk.transform.localPosition = new Vector3(chunk.transform.localPosition.x, chunk.transform.localPosition.y, 10);

        DataManager.instance.winCountdown--;

        if(DataManager.instance.winCountdown == 0)
        {
            GameManager.instance.OnEndGame();
        }
    }
    public void ExitState()
    {
        DataManager.instance.winCountdown++;
    }
}
