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
    private float currHealth = 100f;

    private void Start()
    {
        if (StateNameController.camNumber == 1)
        {
            vrCam.SetActive(true);
            kbmCam.SetActive(false);
        }
        else if (StateNameController.camNumber == 2)
        {
            vrCam.SetActive(false);
            kbmCam.SetActive(true);
        }
        currHealth = 100f;
        healthText.color = new Color(0, 255, 0);
    }


    public void updateHealth(float damage)
    {
        if(currHealth > 0f) { 
            currHealth -= damage;
            healthText.text = "Health: " + currHealth.ToString();
        } 
        if(currHealth <= 0f)
        {
            healthText.color = new Color(255,0,0);
            healthText.text = "YOU DIED";
        }
        
    }
}
