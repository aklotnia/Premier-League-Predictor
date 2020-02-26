import React from 'react'
import { JSCharting } from 'jscharting-react'

class ProbableOutcome extends React.Component {
   
    state = {
        home_team: this.props.home_team,
        away_team: this.props.away_team
    }

    stateSetter =  (home_team, away_team) => {
        fetch(`http://localhost:3000/games/${this.props.home_team}/${this.props.away_team}`)
        .then(resp => resp.json())
        .then(parsed => {this.setState({prediction: parsed, home_team: home_team, away_team: away_team})})
    }

    componentDidMount () {
        this.stateSetter(this.props.home_team, this.props.away_team)
    }

    componentDidUpdate () {
        if (this.props.home_team !== this.state.home_team || this.props.away_team !== this.state.away_team) {
            this.stateSetter(this.props.home_team, this.props.away_team)
        }
    }

    renderGraph = () => {
        if (this.state.prediction) {
            let predictiontreated = this.state.prediction.probabilities.map((prediction) => {
                let hash = {}

                let name_ar = prediction["result name"].split("_")

                let home_team_array = name_ar[0].split(' ')
                home_team_array.pop()

                // let final_home_abbrev = home_team_array.map((name) => {
                //     return name[0]
                // })
                // .join("")

                let final_home_abbrev = home_team_array[0]

                let away_team_array = name_ar[1].split(' ')
                away_team_array.pop()

                // let final_away_abbrev = away_team_array.map((name) => {
                //     return name[0]
                // })
                // .join("")

                let final_away_abbrev = away_team_array[0]

                hash["x"] = `${final_home_abbrev}-${final_away_abbrev}`
                hash["y"] = prediction["probability"] * 100

                return hash
            })

            let option_hash = {
                type: "vertical column",
                series: [
                    {
                        "name": "results accounted for",
                        "points": predictiontreated.slice(0, 13)
                    }
                ],
                title: {
                    position: 'center',
                    label: {
                        text: `Scorelines for ${this.props.home_team} Vs. ${this.props.away_team}`,
                        style: {
                            fontSize: 20,
                            fontFamily: "Arial",
                            fontWeight: "bold"
                        },
                        align: 'center',
                        verticalAlign: 'top'
                    }
                },
                xAxis: [
                    {
                        label: {
                            text: `Scorelines (${this.props.home_team}-${this.props.away_team})`
                        }
                    }
                ],
                yAxis: [
                    {
                        label: {
                            text: "Probability (%)"
                        }
                    }
                ],
                legend: {
                    position: "bottom"
                }
                
            }
            return <div id="ProbableOutcome" style={{maxWidth: '900px', height: '500px'}}><JSCharting options={option_hash} mutable={true} /></div>
            }
        }

    render () {
        return(
            <div>
                {this.renderGraph()}
            </div>
        )
    }
}

export default ProbableOutcome