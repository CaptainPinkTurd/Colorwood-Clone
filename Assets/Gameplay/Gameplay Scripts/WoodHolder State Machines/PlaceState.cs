using UnityEngine;

public class PlaceState : IWoodHolderState
{
    public void EnterState(StateManager woodHolderState, WoodHolder holder)
    {
        DataManager.instance.selectedChunk.OnNewHolder(DataManager.instance.lastSelectedHolder, holder);
        DataManager.instance.lastSelectedHolder = null;
        DataManager.instance.selectedChunk = null;
    }
}
