using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

public class CustomButton : CustomUIComponent
{
    public UnityEvent onClick;

    private Button button;

    public override void Configure()
    {
        
    }

    public override void Setup()
    {
        button = GetComponent<Button>();    
    }
    public void OnClick()
    {
        onClick.Invoke();
    }
}
