using UnityEngine;

public class WoodHolderEmptyState : WoodHolderBaseState
{
    public override void EnterState(WoodHolderStateManager woodHolderState, WoodHolder holder)
    {
        
    }

    public override void OnClickEvent(WoodHolderStateManager woodHolderState)
    {
        if (GameManager.instance.selectedChunk == null) return;

        woodHolderState.SwitchState(woodHolderState.placeState);
    }
}
