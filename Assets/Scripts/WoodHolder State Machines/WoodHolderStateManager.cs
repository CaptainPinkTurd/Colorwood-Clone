using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WoodHolderStateManager : MonoBehaviour
{
    [SerializeField] internal WoodHolder woodHolder;
    internal WoodHolderBaseState currentState;

    public WoodHolderEmptyState emptyState = new WoodHolderEmptyState();
    public WoodHolderStackState stackState = new WoodHolderStackState();   
    public WoodHolderSelectedState selectedState = new WoodHolderSelectedState();
    public WoodHolderPlaceState placeState = new WoodHolderPlaceState();
    // Start is called before the first frame update 
    void Start()
    {
        if(woodHolder.cubePieces.Count == 0)
        {
            currentState = emptyState;
        }
        else
        {
            currentState = stackState;
        }
        currentState.EnterState(this, woodHolder);
    }
    public void SwitchState(WoodHolderBaseState state)
    {
        currentState = state;
        currentState.EnterState(this, woodHolder); 
    }
}
