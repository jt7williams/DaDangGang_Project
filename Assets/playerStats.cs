using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class playerStats : MonoBehaviour
{
    private gameController gameController;
    public float maxHealth;
    public float currentHealth;
	
	public float maxTankHealth;
	public float currentTankHealth;
	
    //private bool isDead = false;
    public GameOver GO_SCREEN;

    private void Awake()
    {
        gameController = GameObject.FindObjectOfType<gameController>();
    }

    void Start()
    {
        currentHealth = maxHealth;
		currentTankHealth = maxTankHealth;
    }

    public void takeTankDmg(float damage)
    {
        if (currentTankHealth > 0)
        {
            //isDead = false;
            gameController.updateTankHealth(damage);
            currentTankHealth -= damage;
        }
        else
        {
            die();
        }
    }

    public void takePlayerDMG(float damage)
    {
        if (currentHealth > 0)
        {
            //isDead = false;
            gameController.updateHealth(damage);
            currentHealth -= damage;
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

}
