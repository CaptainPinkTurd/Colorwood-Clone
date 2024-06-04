using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

[System.Serializable]
public class MyStringEvent : UnityEvent<string>
{
}
public class GameEventListener : MonoBehaviour
{
    public GameEvent gameEvent;
    public UnityEvent onEventRaised;
    public MyStringEvent onStringEventRaised;
    private void OnEnable()
    {
        gameEvent.AddListener(this);
    }
    private void OnDisable()
    {
        gameEvent.RemoveListener(this);
    }
    public void OnRaise()
    {
        onEventRaised.Invoke();
    }
    public void OnRaise(string text)
    {
        onStringEventRaised.Invoke(text);
    }
}
