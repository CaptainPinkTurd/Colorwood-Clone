using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(menuName = "Game Event")]
public class GameEvent : ScriptableObject
{
    List<GameEventListener> listeners = new List<GameEventListener>();

    public void RaiseEvent()
    {
        for(int i = listeners.Count - 1; i >= 0; i--)
        {
            listeners[i].OnRaise();
        }
    }
    public void AddListener(GameEventListener listener)
    {
        listeners.Add(listener);
    }
    public void RemoveListener(GameEventListener listener)
    {
        listeners.Remove(listener);
    }
}
