using UnityEngine;

public abstract class WoodHolderBaseState
{
    public abstract void EnterState(WoodHolderStateManager stateManager, WoodHolder holder);
    public abstract void UpdateState(WoodHolderStateManager stateManager);
    public abstract void OnClickEvent(WoodHolderStateManager stateManager);
}
