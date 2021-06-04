using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PCVehicleSensor : MonoBehaviour
{
    public GameObject player;
    private void OnTriggerStay(Collider other)
    {
        if(other.gameObject.tag == "Vehicle")
        //if(other.name == "tankbody")
        {
            Debug.Log("on Vehicle!");
            this.player.transform.SetParent(other.gameObject.transform);
        }
        else
        {
            Debug.Log("no trigger detected");
            //this.player.transform.SetParent(null);
        }
        Debug.Log("trigger: " + other.gameObject.name);
    }
}
