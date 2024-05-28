using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public class WoodDataVisualizer
{
    [System.Serializable]   
    public struct RowData
    {
        public Wood[] holder;
    }
    public RowData[] column = new RowData[4]; 
}
