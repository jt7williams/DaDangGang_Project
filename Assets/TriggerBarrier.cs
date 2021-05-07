using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TriggerBarrier : MonoBehaviour
{
    public GameObject firePillar;
    public GameObject fireRing;
    public GameObject fireBarrier;
    public GameObject barrier;
    public string triggerTag;
    private bool isTriggered;
    // Start is called before the first frame update
    void Start()
    {
        fireBarrier.GetComponent<ParticleSystem>().Stop();
        fireRing.GetComponent<ParticleSystem>().Stop();
        firePillar.GetComponent<ParticleSystem>().Stop();
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    private IEnumerator OnTriggerEnter(Collider other)
    {

        if (!isTriggered && (other.gameObject.tag == triggerTag))
        {
            isTriggered = true;
            other.gameObject.SetActive(false);
            fireRing.GetComponent<ParticleSystem>().Play();
            yield return new WaitForSeconds(1);
            firePillar.GetComponent<ParticleSystem>().Play();
            yield return new WaitForSeconds(1);
            fireBarrier.GetComponent<ParticleSystem>().Play();
            yield return new WaitForSeconds(2);
            barrier.SetActive(false);
        }
    }
}
