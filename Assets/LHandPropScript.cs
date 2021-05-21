using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LHandPropScript : MonoBehaviour
{
    public GameObject LeftHand;


    // Start is called before the first frame update
    void Start()
    {
        this.gameObject.transform.GetChild(0).GetChild(0).gameObject.SetActive(false);

    }

    // Update is called once per frame
    void Update()
    {

    }
    void OnTriggerEnter(Collider C)
    {
        Debug.Log("NAME!\n");
        Debug.Log(C.gameObject.name);
        if (C.gameObject.name == "GrabVolumeSmall")
        {
            LeftHand.SetActive(false);
            this.gameObject.transform.GetChild(0).GetChild(0).gameObject.SetActive(true);
            Debug.Log(C.gameObject.name);
        }
        else
        {
            LeftHand.SetActive(true);
            this.gameObject.transform.GetChild(0).GetChild(0).gameObject.SetActive(false);
        }



    }
    void OnTriggerExit(Collider C)
    {
        Debug.Log("NAME42!\n");
        Debug.Log(C.gameObject.name);
        if (C.gameObject.name == "GrabVolumeSmall")
        {

            LeftHand.SetActive(true);
            this.gameObject.transform.GetChild(0).GetChild(0).gameObject.SetActive(false);

        }

    }
}
