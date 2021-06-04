using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DetectOnVehicle : MonoBehaviour
{
    public VehiclePresetPath vehicle;
    public OVRPlayerController vrPlayer;
    public float defaultSpeed = 5F;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private void OnTriggerEnter(Collider other)
    {

        if (other.gameObject.tag == "Player")
        {
            vrPlayer.OnVehicle = true;
            vehicle.VehicleSpeed = defaultSpeed;
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.gameObject.tag == "Player")
        {
            vrPlayer.OnVehicle = false;
            vehicle.VehicleSpeed = 0F;
        }
    }
}
