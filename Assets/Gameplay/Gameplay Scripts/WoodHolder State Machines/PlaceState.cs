using UnityEngine;

public class PlaceState : IWoodHolderState
{
    NewHolderInvoker newHolderInvoker;
    public void EnterState(StateManager woodHolderState, WoodHolder holder)
    {
        newHolderInvoker = GameManager.instance.newHolderInvoker;

        ICommand newHolderCommand = new OnNewHolderCommand(holder);
        newHolderInvoker.AddCommand(newHolderCommand);

        DataManager.instance.lastSelectedHolder = null;
        DataManager.instance.selectedChunk = null;
    }
}
