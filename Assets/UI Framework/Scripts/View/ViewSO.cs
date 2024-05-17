using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(menuName = "CustomUI/ViewSo", fileName = "ViewSO")]
public class ViewSO : ScriptableObject
{
    public RectOffset padding;
    public float spacing;
}
