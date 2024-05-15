using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class StateManager : MonoBehaviour
{
    [SerializeField] internal WoodHolder woodHolder;
    internal IWoodHolderState currentState;

    public EmptyState emptyState = new EmptyState();
    public StackState stackState = new StackState();   
    public SelectedState selectedState = new SelectedState();
    public PlaceState placeState = new PlaceState();
    public QualifiedState qualifiedState = new QualifiedState();

    void Start()
    {
        currentState = stackState;
        currentState.EnterState(this, woodHolder);
    }
    public void SwitchState(IWoodHolderState state)
    {
        currentState = state;
        currentState.EnterState(this, woodHolder); 
    }
    public void CheckForState()
    {
        if (woodHolder.cubePieces.Count == 0)
        {
            currentState = emptyState;
        }
        else
        {
            currentState = stackState;
        }
        currentState.EnterState(this, woodHolder);
    }
}
