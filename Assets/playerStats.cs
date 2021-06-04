using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class playerStats : MonoBehaviour
{
    private gameController gameController;
    private float maxHealth = 100f;
    public float currentHealth;
    //private bool isDead = false;
    public GameOver GO_SCREEN;

    private void Awake()
    {
        gameController = GameObject.FindObjectOfType<gameController>();
    }

    void Start()
    {
        currentHealth = maxHealth;
    }

    public void takePlayerDMG(float damage)
    {
        if (currentHealth > 0)
        {
            //isDead = false;
            currentHealth -= damage;
            gameController.updateHealth();
            
        }
        else
        {
            die();
        }
    }

    public void die()
    {
        //isDead = true;
        GO_SCREEN.showScreen();
        Debug.Log("YOU ARE DEAD");
    }

    public void heal50()
    {
        currentHealth += 50F;
        if (currentHealth > maxHealth)
        {
            currentHealth = maxHealth;
        }
        gameController.updateHealth();
    }
}
