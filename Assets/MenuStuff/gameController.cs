using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;
using TMPro;

public class gameController : MonoBehaviour
{
    public GameObject vrCam;
    public GameObject kbmCam;

    public TextMeshProUGUI healthText;
	
	
    public TextMeshProUGUI ammoCounter;
    public float currHealth = 100f;
    
	private int maxAmmo = 30;
	
	public TextMeshProUGUI healthTextTank;
	public float currTankHealth = 1000f;
	
	public int score;
	public TextMeshProUGUI scoreText;
	
    //private GunScript gun;
    public playerStats pStats;
    public TextMeshProUGUI healthTextTank;
    public float currTankHealth = 1000f;

    public TextMeshProUGUI VRhealthText;
    public TextMeshProUGUI VRammoCounter;
    public TextMeshProUGUI VRhealthTextTank;

    private void Start()
    {
        if (StateNameController.camNumber == 1)
        {
            vrCam.SetActive(true);
            kbmCam.SetActive(false);
            healthText = VRhealthText;
            ammoCounter = VRammoCounter;
        }
        else if (StateNameController.camNumber == 2)
        {
            vrCam.SetActive(false);
            kbmCam.SetActive(true);
        }
        currHealth = 100f;
        ammoCounter.text = "Ammo: " + maxAmmo.ToString() + "/30";
        healthText.color = new Color(0, 255, 0);
    }

    public void updateAmmoCount(int ammo)
    {
        ammoCounter.color = new Color(255, 255, 255);
        ammoCounter.text = "Ammo: " + ammo.ToString() + "/30";   
    }

    public void reloadText()
    {
    
     ammoCounter.color = new Color(255, 0, 0);
     ammoCounter.text = "RELOADING";

    }

    public void updateHealth(/*float damage*/)
    {
        /*
        if(currHealth > 0f) { 
            currHealth -= damage;
            healthText.text = "Health: " + currHealth.ToString();
        } 
        if(currHealth <= 0f)
        {
            healthText.color = new Color(255,0,0);
            healthText.text = "YOU DIED";
        }
        */
        currHealth = pStats.currentHealth;
        if (currHealth > 0f)
        {
            healthText.text = "Health: " + currHealth.ToString();
        }
        if (currHealth <= 0f)
        {
            healthText.color = new Color(255, 0, 0);
            healthText.text = "YOU DIED";
        }
    }

    public void updateTankHealth(float damage)
    {
        if (currTankHealth > 0f)
        {
            currTankHealth -= damage;
            healthTextTank.text = "Tank Health: " + currTankHealth.ToString();
        }
        if (currTankHealth <= 0f)
        {
            healthTextTank.color = new Color(255, 0, 0);
            healthTextTank.text = "THE TANK DIED";
        }

    }
	
    public void updateTankHealth(float damage)
    {
        if(currTankHealth > 0f) { 
            currTankHealth -= damage;
            healthTextTank.text = "Tank Health: " + currTankHealth.ToString();
        } 
        if(currTankHealth <= 0f)
        {
            healthTextTank.color = new Color(255,0,0);
            healthTextTank.text = "THE TANK DIED";
        }
        
    }
	
	public void addToScore()
	{
		score = score + 10;
		scoreText.text = "Points: " + score.ToString();
	}
}
