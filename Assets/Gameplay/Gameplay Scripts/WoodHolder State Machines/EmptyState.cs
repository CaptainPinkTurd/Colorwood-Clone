using UnityEngine;

public class EmptyState : IWoodHolderState
{
    public void EnterState(StateManager stateManager, WoodHolder holder)
    {
        
    }

    public void OnClickEvent(StateManager woodHolderState)
    {
        if (DataManager.instance.selectedChunk == null) return;

        DataManager.instance.pieceNeededToRemove = 0;
        woodHolderState.SwitchState(woodHolderState.placeState);
    }
}
