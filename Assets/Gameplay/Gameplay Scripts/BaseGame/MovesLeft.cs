using System;
using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class MovesLeft : MonoBehaviour
{
    [SerializeField] TMP_Text movesText;
    private int movesLeft;
    private Level currentLevel;

    void Start()
    {
        currentLevel = GameManager.instance.gameObject.GetComponent<LevelGenerate>().level;

        movesLeft = currentLevel.moveLimit;
        movesText.text = "Moves left: " + movesLeft;
    }

    public void Countdown()
    {
        movesLeft--;
        movesText.text = "Moves left: " + movesLeft;

        StartCoroutine(GameManager.instance.LoseConditionCheck(movesLeft));
    }
}
