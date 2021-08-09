<!DOCTYPE html>
<html>
<head>
<style>
.contents{
    display: flex;
    justify-items: center;
    align-items: center;
    flex-direction: column;

    
}

    .button-zoon{
        display: flex;
        justify-items: center;
        align-items: center;
        flex-direction: row;
    }
        .button-layout button{
            margin: 1vh;
            padding: 1vh;
        }
        .button-layout button:hover{
            margin: 1vh;
            padding: 1vh;
            background-color: gray;
        }

        .button-layout button.clicked{
            margin: 1vh;
            padding: 1vh;
            background-color: gray;
            border: 1px solid black;
            border-top: 2px solid black;
            border-left: 2px solid black;
        }

        .alien_list{
            display: block;
            align-self: flex-end;
            margin-right: 50vh;
            margin-bottom: 5vh;
        }
        .alien_list button{
            border: none;
            font-size: 15px;
            background-color:transparent;
            color: black;
        }
        .alien_list button:hover{
            color: red;
            cursor: pointer;
        }
        .alien_list button.clicked{
            color: red;
            cursor: pointer;
        }


    .content-zoon_maide{
	overflow-y:scroll; 

       
    }   
        .item-box{
            width: 900px;
            display: flex;
            flex-wrap: wrap;
            margin: 0 auto;

            
        }
            .item-one{
                width: 800px;
                height: 200px;
                margin: 1%;
                border: 1px solid black;
                display: flex;
            }
                .img-zoon{
                    margin: 5px;
                    border: 1px solid black;
                    overflow: hidden;
                    display: flex;
                }
                .img-zoon img{
                    max-width: 174px;
                    max-height: 175px;
                    min-width: 175px;
                    min-height: 175px;
                    
                }
                .dretion-zoon{
                    margin-top: 2vh;
                }
                .love-time{
                    margin-top: 3vh;
                    display: flex;
                    flex-direction: row;
                    justify-content: space-between;
                }
                .auction{
                    display: flex;
                    flex-direction: row;
                    font-size: 12px;
                    opacity: 0.5;
                }
                .xianzai{
                    font-size: 20px;
                }
                .endtime-zoon{
                    display: flex;
                    flex-direction: row;
                    color: red;
                    font-size: 15px;
                }
                .nick{
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    font-size: 30px;
                }
                .c_code{
                    border: 1px solid black;
                    justify-self: center;
                }
                .c_zoon{
                    margin: 3%;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                }
                .mai-time{
                    margin-left: 6%;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                }
</style>
</head>
<body>
    <div class="contents">
        <div class="content-zoon_maide">
            <div class="item-box">
                
            </div>
        </div>
    </div>
</body>
</html>