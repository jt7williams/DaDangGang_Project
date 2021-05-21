using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class gameController : MonoBehaviour
{
    public GameObject vrCam;
    public GameObject kbmCam;

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
    }

}
