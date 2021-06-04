using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DetectOnVehicle : MonoBehaviour
{
    public VehiclePresetPath vehicle;
    public OVRPlayerController vrPlayer;
    public float defaultSpeed = 5F;

    public float initialSpeed;
    public MovementControl pcPlayer;

    // Start is called before the first frame update
    void Start()
    {
        initialSpeed = vehicle.VehicleSpeed;
        vehicle.VehicleSpeed = 0;
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
            //vehicle.VehicleSpeed = defaultSpeed;
            pcPlayer.OnVehicle = true;
            //Debug.Log("OnVehicle Player Enter");

            vehicle.VehicleSpeed = initialSpeed;
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.gameObject.tag == "Player")
        {
            vrPlayer.OnVehicle = false;
            pcPlayer.OnVehicle = false;

            vehicle.VehicleSpeed = 0F;
        }
    }
}
