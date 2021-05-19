using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RespawnKey : MonoBehaviour
{
    public GameObject key;
    public Transform spawnPoint;
    //public float respawnTime;
    //private float timeStayingStill;
    


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
        if (other.gameObject.name == "Terrain")
        {
            //Debug.Log(other.gameObject.name);
            key.transform.position = spawnPoint.position;
            key.transform.rotation = spawnPoint.rotation;
            key.GetComponent<Rigidbody>().velocity = Vector3.zero;
        }
    }
}
