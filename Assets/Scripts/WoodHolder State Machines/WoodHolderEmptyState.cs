using UnityEngine;

public class WoodHolderEmptyState : WoodHolderBaseState
{
    public override void EnterState(WoodHolderStateManager woodHolderState, WoodHolder holder)
    {
        Debug.Log("Hello from empty state");
    }

    public override void OnClickEvent(WoodHolderStateManager woodHolderState)
    {
        if (GameManager.instance.selectedChunk == null)
        {
            Debug.Log("Click event from empty state");
            return;
        }
        woodHolderState.SwitchState(woodHolderState.placeState);
    }

    public override void UpdateState(WoodHolderStateManager woodHolderState)
    {
        throw new System.NotImplementedException();
    }
}
