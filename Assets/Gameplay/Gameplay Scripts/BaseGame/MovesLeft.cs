using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

public class MovesLeft : MonoBehaviour
{
    [SerializeField] TMP_Text movesText;
    private int movesLeft;

    void Start()
    {
        movesLeft = DataManager.instance.winCountdown * 4;
        movesText.text = "Moves left: " + movesLeft;
    }

    public void Countdown()
    {
        movesLeft--;
        movesText.text = "Moves left: " + movesLeft;

        if(movesLeft == 0) GameManager.instance.OnLose();
    }
}
