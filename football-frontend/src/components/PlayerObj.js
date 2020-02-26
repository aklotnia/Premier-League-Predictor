import React from 'react'
import ReactTooltip from 'react-tooltip'
// import { JSCharting } from 'jscharting-react'
import { Draggable } from 'react-drag-and-drop'

class PlayerObj extends React.Component {

    state = {
        hovered: true
        
    }

    goalieOptionHash = () => {
        return {
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
              name: this.props.player.name,
              points: [
                { name: 'SPer', y: this.props.player.save_percentage / 100  },
                { name: 'PKSPer', y: this.props.player.penalty_kick_save_percentage / 100 },
                { name: 'CPLB', y: this.props.player.accurate_long_balls_per_game }
              ]
            }
        ]       
            }
    }

    defenseOptionHash = () => {
        return {
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
              name: this.props.player.name,
              points: [
                { name: 'CPG', y: this.props.player.conceded_per_game  },
                { name: 'TacklingTendency', y: this.props.player.tackles_per_game},
                { name: 'TA', y: this.props.player.tackle_accuracy / 50 }
              ]
            }
        ]       
            }
    }

    midfieldOptionHash = () => {
        return {
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
              name: this.props.player.name,
              points: [
                { name: 'IPG', y: this.props.player.interceptions_per_game  },
                { name: 'AWR', y: this.props.player.aerial_win_rate / 100  },
                { name: 'TBPG', y: this.props.player.through_balls_per_game },
                { name: 'PPG', y: this.props.player.passes_per_game / 100 }
              ]
            }
        ]       
            }
    }

    forwardOptionHash = () => {
        return {
        type: "radar spider",
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
              name: this.props.player.name,
              points: [
                { name: 'GPG', y: this.props.player.goals_per_game  },
                { name: 'APG', y: this.props.player.assists_per_game  },
                { name: 'BCPG', y: this.props.player.big_chances_created_per_game },
                { name: 'SA', y: this.props.player.shooting_accuracy / 100 }
              ]
            }
        ]
            }
    }

    

    



    // positionFilter = () => {
    //     if (this.state.hovered) {
    //     switch (this.props.player.position) {
    //         case "GK":
    //         return(
    //             <JSCharting options={this.goalieOptionHash()} />
    //         )
            
    //         case "D":
    //         return(
    //             <JSCharting options={this.defenseOptionHash()} />
    //         )

    //         case "M":
    //         return(
    //             <JSCharting options={this.midfieldOptionHash()} />
    //         )

    //         case "F":
    //         return(
    //             <JSCharting options={this.forwardOptionHash()} />
    //         )
       
    //         default:
    //             break;
    //    }
    // }
    // }

    positionFilter = () => {
          if (this.state.hovered) {
          switch (this.props.player.position) {
              case "GK":
              return(
                  <div className="PlayerFloatInfo">
                    <div>Position: Goalkeeper</div>
                    <br></br>
                    <div>Save Rate: {this.props.player.save_percentage}%</div>
                    <div>PK Save Rate: {this.props.player.penalty_kick_save_percentage}%</div>
                    <div>Long Balls P/G: {this.props.player.accurate_long_balls_per_game}</div>
                  </div>
              )
              
              case "D":
              return(
                <div className="PlayerFloatInfo">
                    <div>Position: Defense</div>
                    <br></br>
                    <div>Conceded P/G: {this.props.player.conceded_per_game}</div>
                    <div>Tackles P/G: {this.props.player.tackles_per_game}</div>
                    <div>Tackle Accuracy: {this.props.player.tackle_accuracy}%</div>
                    <div>Defensive Errors: {this.props.player.errors_leading_to_goals_per_game} </div>
                  </div>
              )
  
              case "M":
              return(
                <div className="PlayerFloatInfo">
                    <div>Position: Midfield</div>
                    <br></br>
                    <div>Interceptions P/G: {this.props.player.interceptions_per_game}</div>
                    <div>Aerial Win Rate: {this.props.player.aerial_win_rate}%</div>
                    <div>Through Balls P/G: {this.props.player.through_balls_per_game}</div>
                    <div>Passes P/G: {this.props.player.passes_per_game} </div>
                  </div>
              )
  
              case "F":
              return(
                <div className="PlayerFloatInfo">
                    <div>Position: Forward</div>
                    <br></br>
                    <div>Goals P/G: {this.props.player.goals_per_game}</div>
                    <div>Assist P/G: {this.props.player.assists_per_game}</div>
                    <div>Big Chances P/G: {this.props.player.big_chances_created_per_game}</div>
                    <div>Shooting Accuracy: {this.props.player.shooting_accuracy}%</div>
                  </div>
              )
         
              default:
                  break;
         }
      }
      }
  

    enterHover = () => {
        this.setState({hovered: true})
    }

    render() {
        return(
          <div>
            <div className="PlayerObj" onMouseEnter={this.enterHover} data-tip data-for={this.props.player.name}>
                <Draggable type={`${this.props.team.toLowerCase()}${this.props.player.position[0].toLowerCase()}`} data={[this.props.player.name, this.props.player.image]}><img className="DroppableImage" src={this.props.player.image} alt={this.props.player.name} /></Draggable>
                <span>{this.props.player.name}</span>
                    <ReactTooltip id={this.props.player.name}>
                      <div>
                        <h2>{this.props.player.name}</h2>
                        <div className="PlayerHoverGrid">
                            <img className="PlayerImg" src={this.props.player.image} alt={this.props.player.name}/>
                            <div className="Graph">
                                {this.positionFilter()}
                            </div>
                        </div>
                      </div>
                    </ReactTooltip>
            </div>
              <hr className="PlayerBreak"></hr>
            </div>
        )
    }
}

export default PlayerObj