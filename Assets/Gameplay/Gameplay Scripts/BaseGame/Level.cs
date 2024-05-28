using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "New Level", menuName = "Scriptable Objects/Level")]
public class Level : ScriptableObject
{
    public int columnPerRow;
    public int rowNumbers;
    public float firstRowHeight; //the height of which the first row should be positioned to 
    public int moveLimit;
    public WoodDataVisualizer[] woodTypeRows;
}
