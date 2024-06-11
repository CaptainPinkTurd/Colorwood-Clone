using System.Linq;
using Unity.VisualScripting.FullSerializer;
using UnityEngine;

public class SelectedState : IWoodHolderState
{
    public void EnterState(StateManager woodHolderState, WoodHolder holder)
    {
        DataManager.instance.selectedChunk = holder.chunkStack.FirstOrDefault();
        DataManager.instance.selectedChunk.OnSelect();
        DataManager.instance.lastSelectedHolder = holder;
    }

    public void OnClick(StateManager woodHolderState)
    {
        if (DataManager.instance.chunkIsMoving) return; //prevent spamming on the holder, it will offset the selected chunk pos if spam enough

        //if click on the same wood holder again 
        DataManager.instance.selectedChunk?.OnDeselect();
        DataManager.instance.selectedChunk = null;

        woodHolderState.SwitchState(woodHolderState.stackState);
    }
    //Selected State will get transit back to other states in CubeChunk script game event
}
