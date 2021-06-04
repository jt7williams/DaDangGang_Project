using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BoardVehicle : MonoBehaviour
{
    public GameObject vehicle;
    public GameObject vrPlayer;
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
            vrPlayer.transform.position = vehicle.transform.position + new Vector3(0, 3, 0);
        }
    }
}
