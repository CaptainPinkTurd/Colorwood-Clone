using UnityEngine;

public class EmptyState : IWoodHolderState
{
    public void EnterState(StateManager stateManager, WoodHolder holder)
    {
        
    }

    public void OnClickEvent(StateManager woodHolderState)
    {
        if (DataManager.instance.selectedChunk == null) return;

        woodHolderState.SwitchState(woodHolderState.placeState);
    }
}
