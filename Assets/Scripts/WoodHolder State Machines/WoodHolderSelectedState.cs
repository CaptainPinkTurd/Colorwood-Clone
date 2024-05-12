using System.Linq;
using UnityEngine;

public class WoodHolderSelectedState : WoodHolderBaseState
{
    public override void EnterState(WoodHolderStateManager woodHolderState, WoodHolder holder)
    {
        Debug.Log("Hello from Select state");
        GameManager.instance.selectedChunk = holder.chunkStack.FirstOrDefault();
        GameManager.instance.selectedChunk.OnSelect();
        GameManager.instance.lastSelectedHolder = holder;
    }

    public override void OnClickEvent(WoodHolderStateManager woodHolderState)
    {
        //if click on the same wood holder again 
        GameManager.instance.selectedChunk.OnDeselect();
        GameManager.instance.selectedChunk = null;

        //holder.isSelected = false;
        woodHolderState.SwitchState(woodHolderState.stackState);
    }

    public override void UpdateState(WoodHolderStateManager woodHolderState)
    {
        throw new System.NotImplementedException();
    }
}
