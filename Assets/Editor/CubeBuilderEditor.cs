using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

[CustomEditor(typeof(Level))]
public class CubeBuilderEditor : Editor
{
    public override void OnInspectorGUI()
    {
        base.OnInspectorGUI();

        Level levelData = (Level)target;    

        if(GUILayout.Button("Generate Cube Pieces", GUILayout.Height(20)))
        {
            levelData.GenerateCubePiece();
        }
    } 
}                                                              