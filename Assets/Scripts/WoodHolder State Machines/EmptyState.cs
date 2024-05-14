using UnityEngine;

public class EmptyState : IWoodHolderState
{
    public void EnterState(StateManager stateManager, WoodHolder holder)
    {
        
    }

    public void OnClickEvent(StateManager woodHolderState)
    {
        if (DataManager.instance.selectedChunk == null)
        {
            Debug.Log("Click event from empty state");
            return;
        }
        woodHolderState.SwitchState(woodHolderState.placeState);
    }
}
