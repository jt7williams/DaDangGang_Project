using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SelfDestruct : MonoBehaviour
{
    public float timer = 5;
    private float currTime = 0;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (currTime >= timer)
        {
            Destroy(this.gameObject);
        }
        currTime += Time.deltaTime;
    }
}
