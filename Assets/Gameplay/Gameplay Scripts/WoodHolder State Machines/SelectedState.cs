using System.Linq;
using UnityEngine;

public class SelectedState : IWoodHolderState
{
    public void EnterState(StateManager woodHolderState, WoodHolder holder)
    {
        DataManager.instance.selectedChunk = holder.chunkStack.FirstOrDefault();
        DataManager.instance.selectedChunk.OnSelect();
        DataManager.instance.lastSelectedHolder = holder;
    }

    public void OnClickEvent(StateManager woodHolderState)
    {
        //if click on the same wood holder again 
        DataManager.instance.selectedChunk.OnDeselect();
        DataManager.instance.selectedChunk = null;

        //holder.isSelected = false;
        woodHolderState.SwitchState(woodHolderState.stackState);
    }
    //Selected State will get transit back to other states in CubeChunk script game event
}
