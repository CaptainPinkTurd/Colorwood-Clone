using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class View : CustomUIComponent
{
    public ViewSO viewData;

    public GameObject containerTop;
    public GameObject containerMiddle;
    public GameObject containerBottom;

    private Image imageTop;
    private Image imageBottom;

    private VerticalLayoutGroup verticalLayoutGroup;

    public override void Configure()
    {
        verticalLayoutGroup.padding = viewData.padding;
        verticalLayoutGroup.spacing = viewData.spacing;
    }

    public override void Setup()
    {
        verticalLayoutGroup = GetComponent<VerticalLayoutGroup>();
        imageTop = containerTop.GetComponent<Image>();  
        imageBottom = containerBottom.GetComponent<Image>();        
    }
}
