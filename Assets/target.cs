using UnityEngine;

public class target : MonoBehaviour
{
    public float health = 50f;

    public void damageTake(float amt){
        health -= amt;
        if(health <= 0f){
            dead();
        }
    }

    void dead(){
        Destroy(gameObject);
    }
}
