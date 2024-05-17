using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ButtonViewModel : MonoBehaviour
{
    public CustomButton buton;

    [Header("Event")]
    public GameEvent onClick;

    public void OnClick()
    {
        onClick.RaiseEvent();   
    }
}
