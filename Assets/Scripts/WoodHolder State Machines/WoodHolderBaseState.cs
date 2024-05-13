using UnityEngine;

public abstract class WoodHolderBaseState
{
    public abstract void EnterState(WoodHolderStateManager stateManager, WoodHolder holder);
    public virtual void UpdateState(WoodHolderStateManager stateManager)
    {

    }
    public virtual void OnClickEvent(WoodHolderStateManager stateManager)
    {

    }
}
