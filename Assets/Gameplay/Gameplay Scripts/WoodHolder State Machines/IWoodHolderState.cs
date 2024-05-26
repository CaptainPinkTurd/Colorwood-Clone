using UnityEngine;

public interface IWoodHolderState
{
    void EnterState(StateManager stateManager, WoodHolder holder);
    void UpdateState(StateManager stateManager)
    {

    }
    void OnClick(StateManager stateManager)
    {

    }
    void ExitState()
    {

    }
}
