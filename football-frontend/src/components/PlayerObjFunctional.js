import React, { useState } from 'react'
import ReactTooltip from 'react-tooltip'
import { JSCharting } from 'jscharting-react'
import { useDrag } from 'react-dnd'

function PlayerObjFunctional(props) {


    const [hovered, setHovered] = useState(false);
    const [collectedProps, drag] = useDrag({
        item: { collectedProps.player },
    })


    let goalieOptionHash =
        {
        type: "radar spider",
        title: {
            position: 'center',
            label: {
              text: 'Goalkeeping Statisics',
              style: {fontWeight: 'bold', fontSize: "30"}
            }
          },
          yAxis: [
            {
              /*The main/default y axis.*/
              scale: {
                range: [0, 1]
                }
            }
          ],
          legend: {
              position: "bottom"
          },
        defaultSeries: { opacity: 0.55, line_width: 4  },
        series: [
            {
              type: 'area',
              name: props.player.name,
              points: [
                { name: 'SPer', y: props.player.save_percentage / 100  },
                { name: 'PKSPer', y: props.player.penalty_kick_save_percentage / 100 },
                { name: 'CPLB', y: props.player.accurate_long_balls_per_game }
              ]
            }
        ]       
            }
    

    let defenseOptionHash =
        {
        type: "radar spider",
        title: {
            position: 'center',
            label: {
              text: 'Defensive Statisics',
              style: {fontWeight: 'bold', fontSize: "30"}
            }
          },
          yAxis: [
            {
              /*The main/default y axis.*/
              scale: {
                range: [0, 2]
              }
            }
          ],
          legend: {
              position: "bottom"
          },
        defaultSeries: { opacity: 0.55, line_width: 4  },
        series: [
            {
              type: 'area',
              name: props.player.name,
              points: [
                { name: 'CPG', y: props.player.conceded_per_game  },
                { name: 'TPG', y: props.player.tackles_per_game  },
                { name: 'TA', y: props.player.tackle_accuracy / 50 },
                { name: 'EPG', y: props.player.errors_leading_to_goals_per_game }
              ]
            }
        ]       
            }
    

    let midfieldOptionHash =
        {
        type: "radar spider",
        title: {
            position: 'center',
            label: {
              text: 'Midfield Statisics',
              style: {fontWeight: 'bold', fontSize: "30"}
            }
          },
          yAxis: [
            {
              /*The main/default y axis.*/
              scale: {
                range: [0, 1]
            }
            }
          ],
          legend: {
              position: "bottom"
          },
        defaultSeries: { opacity: 0.55, line_width: 4  },
        series: [
            {
              type: 'area',
              name: props.player.name,
              points: [
                { name: 'IPG', y: props.player.interceptions_per_game  },
                { name: 'AWR', y: props.player.aerial_win_rate / 100  },
                { name: 'TBPG', y: props.player.through_balls_per_game },
                { name: 'PPG', y: props.player.passes_per_game / 100 }
              ]
            }
        ]       
            }

    let forwardOptionHash = 
        {type: "radar spider",
        title: {
            position: 'center',
            label: {
              text: 'Offensive Statisics',
              style: {fontWeight: 'bold', fontSize: "30"}
            }
          },
          yAxis: [
            {
              /*The main/default y axis.*/
              scale: {
                range: [0, 1]
              }
            }
          ],
          legend: {
              position: "bottom"
          },
        defaultSeries: { opacity: 0.55, line_width: 4  },
        series: [
            {
              type: 'area',
              name: props.player.name,
              points: [
                { name: 'GPG', y: props.player.goals_per_game  },
                { name: 'APG', y: props.player.assists_per_game  },
                { name: 'BCPG', y: props.player.big_chances_created_per_game },
                { name: 'SA', y: props.player.shooting_accuracy / 100 }
              ]
            }
        ]
            }
    

    

    



    let positionFilter = () => {
        if (hovered) {
        switch (props.player.position) {
            case "GK":
            return(
                <JSCharting options={goalieOptionHash} mutable={true} />
            )
            
            case "D":
            return(
                <JSCharting options={defenseOptionHash} mutable={true} />
            )

            case "M":
            return(
                <JSCharting options={midfieldOptionHash} mutable={true} />
            )

            case "F":
            return(
                <JSCharting options={forwardOptionHash} mutable={true} />
            )
       
            default:
                break;
       }
    }
    }

    // enterHover = () => {
    //     setState({hovered: true})
    // }

    
        return(
            <div ref={drag} className="PlayerObj" onMouseEnter={() => {setHovered(true)}} data-tip data-for={props.player.name}>
                <div>{props.player.name}</div>
                    <ReactTooltip id={props.player.name}>
                        <div className="PlayerHoverGrid">
                            <img className="PlayerImg" src={props.player.image} alt={props.player.name}/>
                            <div className="Graph">
                                {positionFilter()}
                            </div>
                        </div>
                    </ReactTooltip>
            </div>
        )
    
}

export default PlayerObjFunctional