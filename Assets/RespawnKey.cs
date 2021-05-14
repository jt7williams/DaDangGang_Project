using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RespawnKey : MonoBehaviour
{
    public GameObject key;
    public Transform spawnPoint;
    public float respawnTime;
    private float timeStayingStill;


    // Start is called before the first frame update
    void Start()
    {
        timeStayingStill = 0F;
        
    }

    // Update is called once per frame
    void Update()
    {
        if ((key.GetComponent<Rigidbody>().velocity).magnitude < 0.01F)
        {
            timeStayingStill += Time.deltaTime;
            if (timeStayingStill > respawnTime)
            {
                key.transform.position = spawnPoint.position;
            }
        }
        else
        {
            timeStayingStill = 0;
        }


    }
}
