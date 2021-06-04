using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DetectOnVehicle : MonoBehaviour
{
    public VehiclePresetPath vehicle;
    public OVRPlayerController vrPlayer;
    public float defaultSpeed = 5F;

    public MovementControl pcPlayer;
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

            //pcplayer.transform.SetParent(vehicle.gameObject.transform);
            pcPlayer.OnVehicle = true;
            Debug.Log("OnVehicle Player Enter");
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.gameObject.tag == "Player")
        {
            vrPlayer.OnVehicle = false;
            vehicle.VehicleSpeed = 0F;

            pcPlayer.OnVehicle = false;
            Debug.Log("OnVehicle PLayer Exit");
        }
    }
}
